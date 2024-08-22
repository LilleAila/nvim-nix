# TODO: read readmes, add keybinds, specify default languages (from readme), add toggle for nynorsk / bokmål?
# Using FTP and HTTPS as the protocol both result in the same file, so i don't know which is faster to use
{ pkgs, mkKeymap, ... }:
{
  opts = {
    spell = true;
    spelllang = "en_us";
  };

  plugins.which-key.registrations = {
    "<leader>p".name = " Spellcheck";
    "<leader>pl".name = "󰗊 Language";
  };

  keymaps = [
    # Switch between langs. Always have english as secondary. Could probably declare in a better way.
    # The first language of `spelllang` (or `spl`) is used for the personal spell file
    (mkKeymap "n" "<leader>plb" ":set spl=nb,en_us<cr>" "Norsk bokmål")
    (mkKeymap "n" "<leader>pln" ":set spl=nn,en_us<cr>" "Norsk nynorsk")
    (mkKeymap "n" "<leader>ple" ":set spl=en_us<cr>" "US english")
    (mkKeymap "n" "<leader>plf" ":set spl=fr,en_us<cr>" "Français")
    (mkKeymap "n" "<leader>plt" ":set spl=de,en_us<cr>" "Deutsch")
    (mkKeymap "n" "<leader>pld" ":set spl=da,en_us<cr>" "Dansk")
    (mkKeymap "n" "<leader>pls" ":set spl=sv,en_us<cr>" "Svenska")
  ];

  extraFiles = {
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_nb.txt
    "spell/nb.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/nb.utf-8.spl";
      hash = "sha256-PImo8hi6Wk9Lt+OO6O+yFezcE2/R4lFTIihEZ7JD/88=";
    };
    "spell/nb.latin1.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/nb.latin1.spl";
      hash = "sha256-S8yq3lr9gm6CFBHVmzHwgctV0Y5ll7ySGkoERgz7ipg=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_nn.txt
    "spell/nn.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/nn.utf-8.spl";
      hash = "sha256-PSnDZyF/Qur3wJHCBSr0hMWPimxa7dRjq+RDo86kS8A=";
    };
    "spell/nn.latin1.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/nn.latin1.spl";
      hash = "sha256-NV3pIZ0yoDBc5b70z/ozG8rwFS7rmeEJsb5i9AwjV7c=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_fr.txt
    "spell/fr.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/fr.utf-8.spl";
      hash = "sha256-q/uXArmNiHwXWs5Y8as5cz3AjQO2dNkU9WNE74bmO2E=";
    };
    "spell/fr.latin1.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/fr.latin1.spl";
      hash = "sha256-CGzNoIkVlMk+qxQ6qD/7vSXQE8G4KGa7tIuxy3iMwv8=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_en.txt
    "spell/en.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/en.utf-8.spl";
      hash = "sha256-/sq9yUm2o50ywImfolReqyXmPy7QozxK0VEUJjhNMHA=";
    };
    "spell/en.latin1.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/en.latin1.spl";
      hash = "sha256-Yg2e/Nec/J1jmBj7UoB+Pa5ho3yADWlKAQzVJaIWGEU=";
    };
    "spell/en.ascii.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/en.ascii.spl";
      hash = "sha256-zry6SJ1F2jNVlA80BYLiDONezc1E+cwWi+hz8I54JEk=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_de.txt
    "spell/de.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl";
      hash = "sha256-c8cQfqM5hWzb6SHeuSpFk5xN5uucByYdobndGfaDo9E=";
    };
    "spell/de.latin1.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/de.latin1.spl";
      hash = "sha256-iedU+cMNolKlNP6aSzTeDV/72DlnuqWccb/yb/UAw0I=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_da.txt
    "spell/da.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/da.utf-8.spl";
      hash = "sha256-kmorKLt1tRESopA8mLD1HfFvEMuDcvXugpH4Y2nAiTI=";
    };
    "spell/da.latin1.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/da.latin1.spl";
      hash = "sha256-HFpTgE2YQpYbIGHQvnLSQ4cdTvqnGZ76SbiN6d9iFMg=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_sv.txt
    "spell/sv.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/sv.utf-8.spl";
      hash = "sha256-c+0oRaF2bKIdU4j8dm2SYHSpCnupIjRY/A0Nzsxyq1I=";
    };
    "spell/sv.latin1.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/sv.latin1.spl";
      hash = "sha256-qo/1RIHx7CC0Mv9fezU6P2rJAX2ABrUobZAtiNixl4c=";
    };
  };
}
