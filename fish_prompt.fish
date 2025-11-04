# name: Default
# author: Lily Ballard

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Nix dev-shell indicator
    # Show a small yellow indicator when inside a nix dev shell.
    # We prefer IN_NIX_SHELL, but also check common vars like NIX_SHELL or DEV_SHELL.
    set -l nix_indicator ''
    if set -q IN_NIX_SHELL
        # Try to get a short name for the shell from NIX_SHELL or DEV_SHELL if present.
        set -l nix_name ''
        if set -q NIX_SHELL
            if command -sq basename
                set nix_name (basename $NIX_SHELL)
            else
                # Fallback: try to strip to last path component
                set nix_name (string split '/' $NIX_SHELL | string trim)
                set nix_name $nix_name[-1]
            end
        else if set -q DEV_SHELL
            set nix_name $DEV_SHELL
        end

        if test -n "$nix_name"
            set nix_indicator ' '(set_color yellow)"⟪$nix_name⟫"(set_color normal)
        else
            set nix_indicator ' '(set_color yellow)'⟪nix⟫'(set_color normal)
        end
    else if set -q NIX_SHELL
        # Some setups only set NIX_SHELL; treat that as an indicator too.
        set -l nix_name ''
        if command -sq basename
            set nix_name (basename $NIX_SHELL)
        else
            set nix_name (string split '/' $NIX_SHELL | string trim)
            set nix_name $nix_name[-1]
        end
        set nix_indicator ' '(set_color yellow)"⟪$nix_name⟫"(set_color normal)
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s (prompt_login)$nix_indicator' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end
