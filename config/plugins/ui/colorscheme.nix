{
  pkgs,
  colorScheme,
  ...
}: {
  extraPlugins = [
    {
      plugin = import ./colorscheme.nix {inherit pkgs;} {scheme = colorScheme;};
      config = "colorscheme nix-${colorScheme.slug}";
    }
  ];

  extraConfigLuaPost = let
    c = colorScheme.palette;
  in ''
    hi WinSeparator guifg=#${c.base05} guibg=NONE gui=NONE guisp=NONE
    hi CursorLineNr  guifg=#${c.base0B} guibg=NONE gui=NONE guisp=NONE

    " Most code colors are controlled by `Identifier`
    hi Identifier            guifg=#${c.base0D} guibg=NONE         gui=NONE        guisp=NONE
    hi @lsp.type.property    guifg=#${c.base0C} guibg=NONE         gui=NONE        guisp=NONE
    hi @variable.member      guifg=#${c.base09} guibg=NONE         gui=NONE        guisp=NONE
    hi @boolean              guifg=#${c.base08} guibg=NONE         gui=italic      guisp=NONE
    hi @module               guifg=#${c.base08} guibg=NONE         gui=none        guisp=NONE
    hi Comment               guifg=#${c.base04} guibg=NONE         gui=italic      guisp=NONE
    hi DiagnosticUnnecessary guifg=#${c.base04} guibg=NONE         gui=italic      guisp=NONE
    hi WhichKeyFloat         guifg=#${c.base05} guibg=#${c.base01} gui=NONE        guisp=NONE
    hi WhichKeyGroup         guifg=#${c.base0B} guibg=NONE         gui=italic,bold guisp=NONE
    hi GitSignsCurrentLineBlame guifg=#${c.base05} guibg=NONE gui=italic guisp=NONE
    " hi @comment.todo.comment guifg=#${c.base02} guibg=#${c.base0A} gui=NONE guisp=NONE
    " Neither the above nor the below two lines worked, possibly because this gets
    " loaded before treesitter does. Maybe put it in `extraConfigLuaPost`?
    " hi TodoComment guifg=#${c.base01} guibg=#${c.base0A} gui=NONE guisp=NONE
    " hi! link @comment.todo.comment TodoComment

    " Markup
    hi @markup.link       guifg=#${c.base0E} guibg=NONE gui=underline guisp=NONE
    hi @markup.link.label guifg=#${c.base0D} guibg=NONE gui=bold      guisp=NONE
    hi @markup.heading    guifg=#${c.base09} guibg=NONE gui=bold      guisp=NONE
    hi @markup.raw.block  guifg=#${c.base0C} guibg=NONE gui=italic    guisp=NONE
    " hi @markup.math       guifg=#${c.base0C} guibg=NONE gui=italic    guisp=NONE

    " Some of these values have been defined multiple times!
    " TODO: This works as it should, but because only a few things were added,
    " and nothing changed, I should probably use the builtin vimThemeFromScheme
    " and then run the above commands after it is loaded, in the `config` of extraPlugins
    " Only downside is I will have to import more stuff, but that's ok

    " base16 color highlighting
    hi base00 guifg=#${c.base05} guibg=#${c.base00} gui=NONE guisp=NONE
    hi base01 guifg=#${c.base05} guibg=#${c.base01} gui=NONE guisp=NONE
    hi base02 guifg=#${c.base05} guibg=#${c.base02} gui=NONE guisp=NONE
    hi base03 guifg=#${c.base06} guibg=#${c.base03} gui=NONE guisp=NONE
    hi base04 guifg=#${c.base00} guibg=#${c.base04} gui=NONE guisp=NONE
    hi base05 guifg=#${c.base00} guibg=#${c.base05} gui=NONE guisp=NONE
    hi base06 guifg=#${c.base00} guibg=#${c.base06} gui=NONE guisp=NONE
    hi base07 guifg=#${c.base00} guibg=#${c.base07} gui=NONE guisp=NONE
    hi base08 guifg=#${c.base00} guibg=#${c.base08} gui=NONE guisp=NONE
    hi base09 guifg=#${c.base00} guibg=#${c.base09} gui=NONE guisp=NONE
    hi base0A guifg=#${c.base00} guibg=#${c.base0A} gui=NONE guisp=NONE
    hi base0B guifg=#${c.base00} guibg=#${c.base0B} gui=NONE guisp=NONE
    hi base0C guifg=#${c.base00} guibg=#${c.base0C} gui=NONE guisp=NONE
    hi base0D guifg=#${c.base00} guibg=#${c.base0D} gui=NONE guisp=NONE
    hi base0E guifg=#${c.base00} guibg=#${c.base0E} gui=NONE guisp=NONE
    hi base0F guifg=#${c.base00} guibg=#${c.base0F} gui=NONE guisp=NONE

    call matchadd('base00', 'base00')
    call matchadd('base01', 'base01')
    call matchadd('base02', 'base02')
    call matchadd('base03', 'base03')
    call matchadd('base04', 'base04')
    call matchadd('base05', 'base05')
    call matchadd('base06', 'base06')
    call matchadd('base07', 'base07')
    call matchadd('base08', 'base08')
    call matchadd('base09', 'base09')
    call matchadd('base0A', 'base0A')
    call matchadd('base0B', 'base0B')
    call matchadd('base0C', 'base0C')
    call matchadd('base0D', 'base0D')
    call matchadd('base0E', 'base0E')
    call matchadd('base0F', 'base0F')
  '';
}
