{
  inputs,
  cell,
}: {
  editorconfig = {
    data = {
      root = true;

      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        charset = "utf-8";
        indent_style = "space";
        indent_size = 2;
      };

      "*.{diff,patch}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        indent_size = "unset";
      };

      "*.md" = {
        max_line_length = "off";
        trim_trailing_whitespace = false;
      };

      "{LICENSES/**,LICENSE}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        charset = "unset";
        indent_style = "unset";
        indent_size = "unset";
      };
    };
  };

  # Tool Homepage: https://numtide.github.io/treefmt/
  treefmt = {
    packages = [
      inputs.nixpkgs.alejandra
      inputs.nixpkgs.nodePackages.prettier
      inputs.nixpkgs.nodePackages.prettier-plugin-toml
      inputs.nixpkgs.shfmt
    ];
    devshell.startup.prettier-plugin-toml = inputs.nixpkgs.lib.stringsWithDeps.noDepEntry ''
      export NODE_PATH=${inputs.nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:''${NODE_PATH-}
    '';
    data = {
      formatter = {
        nix = {
          command = "alejandra";
          includes = ["*.nix"];
        };
        prettier = {
          command = "prettier";
          options = ["--plugin" "prettier-plugin-toml" "--write"];
          includes = [
            "*.css"
            "*.html"
            "*.js"
            "*.json"
            "*.jsx"
            "*.md"
            "*.mdx"
            "*.scss"
            "*.ts"
            "*.yaml"
            "*.toml"
          ];
        };
        shell = {
          command = "shfmt";
          options = ["-i" "2" "-s" "-w"];
          includes = ["*.sh"];
        };
      };
    };
  };

  # Tool Homepage: https://github.com/evilmartians/lefthook
  lefthook = {
    data = {
      commit-msg = {
        commands = {
          conform = {
            # allow WIP, fixup!/squash! commits locally
            run = ''
              [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] ||
              conform enforce --commit-msg-file {1}'';
            skip = ["merge" "rebase"];
          };
        };
      };
      pre-commit = {
        commands = {
          treefmt = {
            run = "treefmt --fail-on-change {staged_files}";
            skip = ["merge" "rebase"];
          };
        };
      };
    };
  };
}
