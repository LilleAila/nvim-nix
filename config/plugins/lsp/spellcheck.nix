# TODO: create a derivation that builds languages from [this](https://github.com/vim/vim/tree/master/runtime/spell), because of [this](https://ftp.nluug.nl/pub/vim/runtime/), which means that none of the files will get any updates
{
  pkgs,
  mkKeymap,
  mkRegistration,
  ...
}:
let
  # `globpath(&rtp, "spell/*.spell")` from `spell/cleanadd.vim` expects there to be a subdir called `spell` in the runtimepath.
  # This means that i have to use a subdir of a dir in the runtimepath, thus `.spell/spell`
  spellDir = "$HOME/.spell";
  mkSpellFile = lang: "${spellDir}/spell/${lang}.utf-8.add";
  global_lang = "en_us";
  global_file = mkSpellFile "en_us";
in
{
  # spellDir/spell has to exist for this to work, otherwise an error is thrown. should be synced with syncthing
  opts = {
    spell = false; # Idk if it should be on or off by default, but it can be slow in big files
    # TODO: either create an autocommand checking the file size, check if cwd is obsidian or other notes or something similar
    spl = global_lang;
    spf = global_file;
  };

  # Otherwise the cleanup script complains about not finding the path through a very cryptic error `No such variable: "s:fname"`, which just means that it has to be on runtimepath
  extraConfigLua = ''
    vim.opt.runtimepath:append("${spellDir}")
  '';

  plugins.which-key.settings.spec = [
    # c because spellCheck
    (mkRegistration "<leader>c" " Spellcheck")
    (mkRegistration "<leader>cl" "󰗊 Language")
    (mkRegistration "<leader>cL" "󰗊 Buffer language")
  ];

  keymaps =
    let
      # :h spellfile, :h spelllang
      # The spellfile for the global lang is always enabled
      # Whichever file comes first in `spellfile`or `spf` is the one that gets written to
      _mkSpell = lang: "spl=${lang},${global_lang} spf=${mkSpellFile lang},${global_file}<cr>";
      mkSpell = lang: ":set ${_mkSpell lang}";
      mkSpell' = lang: ":setlocal ${_mkSpell lang}";
    in
    [
      # Switch between langs. Always have english as secondary.
      (mkKeymap "n" "<leader>clb" (mkSpell "nb") "Norsk bokmål")
      (mkKeymap "n" "<leader>cln" (mkSpell "nn") "Norsk nynorsk")
      (mkKeymap "n" "<leader>cle" (mkSpell "en_us") "English US")
      (mkKeymap "n" "<leader>clf" (mkSpell "fr") "Français")
      (mkKeymap "n" "<leader>clt" (mkSpell "de") "Deutsch")
      (mkKeymap "n" "<leader>cld" (mkSpell "da") "Dansk")
      (mkKeymap "n" "<leader>cls" (mkSpell "sv") "Svenska")
      # Switch between langs in local buffer
      (mkKeymap "n" "<leader>cLb" (mkSpell' "nb") "Norsk bokmål")
      (mkKeymap "n" "<leader>cLn" (mkSpell' "nn") "Norsk nynorsk")
      (mkKeymap "n" "<leader>cLe" (mkSpell' "en_us") "US english")
      (mkKeymap "n" "<leader>cLf" (mkSpell' "fr") "Français")
      (mkKeymap "n" "<leader>cLt" (mkSpell' "de") "Deutsch")
      (mkKeymap "n" "<leader>cLd" (mkSpell' "da") "Dansk")
      (mkKeymap "n" "<leader>cLs" (mkSpell' "sv") "Svenska")
      # Other spell-related keymaps (these are actually longer to type than just using the z prefix)
      # but i prefer having them all under <leader>, and it makes them easier to remember
      (mkKeymap "n" "<leader>cg" "zg" "Mark as correct")
      (mkKeymap "n" "<leader>cw" "zw" "Mark as wrong")
      (mkKeymap "n" "<leader>cr" "zr" "Mark as rare") # Correct but rarely used
      (mkKeymap "n" "<leader>cu" "zuw" "Undo mark")
      (mkKeymap "n" "<leader>cc" ":WhichKey z=<cr>" "See suggestions")
      (mkKeymap "n" "<leader>cn" "]s" "Next misspelled word")
      (mkKeymap "n" "<leader>cN" "[s" "Previous misspelled word")
      (mkKeymap "n" "<leader>ca" ":runtime spell/cleanadd.vim | noh<cr>" "Clean spell file")
      (mkKeymap "n" "<leader>cs" ":mkspell! %<cr>" "Save .add file")
      (mkKeymap "n" "<leader>ct" ":setlocal spell!<cr>" "Toggle spellcheck")
    ];

  # Add the source for nvim-cmp. For some reason plugins.cmp-spell.enable didn't work
  extraPlugins = [ pkgs.vimPlugins.cmp-spell ];
  plugins.cmp.settings.sources = [ { name = "spell"; } ];

  # I probably don't actually need any other files than the utf-8 versions
  # utf-8 is hard-coded in `spellfile` anyways, so i think it'd throw an error with a non-utf-8 file
  # Can also use https:// - both result in the same file
  extraFiles = {
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_nb.txt
    "spell/nb.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/nb.utf-8.spl";
      hash = "sha256-PImo8hi6Wk9Lt+OO6O+yFezcE2/R4lFTIihEZ7JD/88=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_nn.txt
    "spell/nn.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/nn.utf-8.spl";
      hash = "sha256-PSnDZyF/Qur3wJHCBSr0hMWPimxa7dRjq+RDo86kS8A=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_fr.txt
    "spell/fr.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/fr.utf-8.spl";
      hash = "sha256-q/uXArmNiHwXWs5Y8as5cz3AjQO2dNkU9WNE74bmO2E=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_en.txt
    "spell/en.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/en.utf-8.spl";
      hash = "sha256-/sq9yUm2o50ywImfolReqyXmPy7QozxK0VEUJjhNMHA=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_de.txt
    "spell/de.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl";
      hash = "sha256-c8cQfqM5hWzb6SHeuSpFk5xN5uucByYdobndGfaDo9E=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_da.txt
    "spell/da.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/da.utf-8.spl";
      hash = "sha256-kmorKLt1tRESopA8mLD1HfFvEMuDcvXugpH4Y2nAiTI=";
    };
    # https://ftp.nluug.nl/pub/vim/runtime/spell/README_sv.txt
    "spell/sv.utf-8.spl".source = pkgs.fetchurl {
      url = "ftp://ftp.nluug.nl/pub/vim/runtime/spell/sv.utf-8.spl";
      hash = "sha256-c+0oRaF2bKIdU4j8dm2SYHSpCnupIjRY/A0Nzsxyq1I=";
    };
  };
}
