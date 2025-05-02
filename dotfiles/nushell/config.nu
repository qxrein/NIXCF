# Nushell Config File
#
# version = "0.100.1"

$env.EDITOR = "hx"
$env.VISUAL = "hx"

# For more information on defining custom themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
# And here is the theme collection
# https://github.com/nushell/nu_scripts/tree/main/themes
let dark_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green
    empty: blue
    bool: light_cyan
    int: white_dimmed
    filesize: cyan
    duration: white
    date: purple_dimmed
    range: white_dimmed
    float: white_dimmed
    string: white_dimmed
    nothing: white_dimmed
    binary: white_dimmed
    cell-path: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: { bg: red fg: white }
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: white_dimmed
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_external_resolved: light_yellow_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_garbage: { fg: white bg: red attr: b }
    shape_glob_interpolation: cyan_bold
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
    shape_raw_string: light_purple
}

let light_theme = {
    # color for nushell primitives
    separator: dark_gray
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    bool: dark_cyan
    int: dark_gray
    filesize: cyan_bold
    duration: dark_gray
    date: purple
    range: dark_gray
    float: dark_gray
    string: dark_gray
    nothing: dark_gray
    binary: dark_gray
    cell-path: dark_gray
    row_index: green_bold
    record: dark_gray
    list: dark_gray
    block: dark_gray
    hints: dark_gray
    search_result: { fg: white bg: red }
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_external_resolved: light_purple_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_garbage: { fg: white bg: red attr: b }
    shape_glob_interpolation: cyan_bold
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
    shape_raw_string: light_purple
}

$env.config = {
    show_banner: true
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    rm: {
        always_trash: false
    }
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
        padding: { left: 1, right: 1 }
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
        header_on_separator: false
    }
    error_style: "fancy"
    display_errors: {
        exit_code: false
        termination_signal: true
    }
    explore: {
        status_bar_background: { fg: "#1D1F21", bg: "#C4C9C6" }
        command_bar_text: { fg: "#C4C9C6" }
        highlight: { fg: "black", bg: "yellow" }
        status: {
            error: { fg: "white", bg: "red" }
            warn: {}
            info: {}
        }
        selected_cell: { bg: light_blue }
    }
    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "plaintext"
        isolation: false
    }
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
        sort: "smart"
        external: {
            enable: true
            max_results: 100
            completer: null
        }
        use_ls_colors: true
    }
    filesize: {
        metric: false
        format: "auto"
    }
    cursor_shape: {
        vi_insert: block
        vi_normal: underscore
    }
    color_config: $dark_theme
    footer_mode: 25
    float_precision: 2
    buffer_editor: "nvim"
    use_ansi_coloring: true
    bracketed_paste: true
    edit_mode: vi
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: false
        osc133: true
        osc633: true
        reset_application_mode: true
    }
    render_right_prompt_on_last_line: false
    use_kitty_protocol: false
    highlight_resolved_externals: false
    recursion_limit: 50
    plugins: {}
    plugin_gc: {
        default: {
            enabled: true
            stop_after: 10sec
        }
        plugins: {}
    }
    hooks: {
        pre_prompt: [{ null }]
        pre_execution: [{ null }]
        env_change: {
            PWD: [{|before, after| null }]
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }"
        command_not_found: { null }
    }
    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: { attr: r }
                description_text: yellow
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: help_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
    ]
    keybindings: [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: completion_previous_menu
            modifier: shift
            keycode: backtab
            mode: [vi_normal, vi_insert]
            event: { send: menuprevious }
        }
        {
            name: escape
            modifier: none
            keycode: escape
            mode: [vi_normal, vi_insert]
            event: { send: esc }
        }
        {
            name: cancel_command
            modifier: control
            keycode: char_c
            mode: [vi_normal, vi_insert]
            event: { send: ctrlc }
        }
        {
            name: quit_shell
            modifier: control
            keycode: char_d
            mode: [vi_normal, vi_insert]
            event: { send: ctrld }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_l
            mode: [vi_normal, vi_insert]
            event: { send: clearscreen }
        }
        {
            name: search_history
            modifier: control
            keycode: char_q
            mode: [vi_normal, vi_insert]
            event: { send: searchhistory }
        }
        {
            name: open_command_editor
            modifier: control
            keycode: char_o
            mode: [vi_normal, vi_insert]
            event: { send: openeditor }
        }
    ]
}

alias vi = nvim
alias zed = zeditor
alias time = date now
alias batt = acpi
use ~/.cache/starship/init.nu
$env.config.show_banner = false
$env.PATH = ($env.PATH | prepend ~/.emacs.d/bin)
$env.PATH = ($env.PATH | split row (char esep) | append "~/.emacs.d/bin")
$env.ANDROID_HOME = (prepend /home/chikoyeat/Android/sdk)

alias emu8086 = ~/.config/nushell/emu8086_runner.nu
source ~/projects/nitrolit/nitrolit.nu
