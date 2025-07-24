local deus_vault = vim.fn.expand('~')..'/Sync/Notes/compendium'
return {
    {
        'obsidian-nvim/obsidian.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim",

        },
        --version = '*',
        ft = 'markdown',
        lazy = true,
        cmd = 'Obsidian',
        opts = {
            workspaces = {
                {
                    name = "compendium",
                    path = deus_vault,
                },
            },
            completion = {
                blink = true,
                min_chars = 1
            },
            new_notes_location = "current_dir",
            note_id_func = function(title)
                return title
            end,
            -- note_frontmatter_func = function(note)
            --     -- Add the title of the note as an alias.
            --     if note.title then
            --         note:add_alias(note.title)
            --     end
            --
            --     local out = { id = note.id, aliases = note.aliases, tags = note.tags }
            --
            --     -- `note.metadata` contains any manually added fields in the frontmatter.
            --     -- So here we just make sure those fields are kept in the frontmatter.
            --     if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            --         for k, v in pairs(note.metadata) do
            --             out[k] = v
            --         end
            --     end
            --
            --     return out
            -- end,

            -- Optional, for templates (see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Using-templates)
            templates = {
                folder = ".templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- A map for custom variables, the key should be the variable and the value a function.
                -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
                -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
                substitutions = {},

                -- A map for configuring unique directories and paths for specific templates
                --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
                customizations = {},
            },

            -- Sets how you follow URLs
            ---@param url string
            follow_url_func = function(url)
                vim.ui.open(url)
                -- vim.ui.open(url, { cmd = { "firefox" } })
            end,

            -- Sets how you follow images
            ---@param img string
            follow_img_func = function(img)
                vim.ui.open(img)
                -- vim.ui.open(img, { cmd = { "loupe" } })
            end,

            picker = {
                -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
                name = "fzf-lua",
                -- Optional, configure key mappings for the picker. These are the defaults.
                -- Not all pickers support all mappings.
                note_mappings = {
                    -- Create a new note from your query.
                    new = "<C-x>",
                    -- Insert a link to the selected note.
                    insert_link = "<C-l>",
                },
                tag_mappings = {
                    -- Add tag(s) to current note.
                    tag_note = "<C-x>",
                    -- Insert a tag at the current location.
                    insert_tag = "<C-l>",
                },
            },

            ui = {
                enable = true, -- set to false to disable all additional syntax features
                ignore_conceal_warn = false, -- set to true to disable conceallevel specific warning
                update_debounce = 200, -- update delay after a text change (in milliseconds)
                max_file_length = 5000, -- disable UI features for files with more than this many lines
                -- Define how various check-boxes are displayed
                checkboxes = {
                    -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                    ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                    ["!"] = { char = "", hl_group = "ObsidianImportant" },
                    -- Replace the above with this if you don't have a patched font:
                    -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                    -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                    -- You can also add more custom ones...
                },
                -- Use bullet marks for non-checkbox lists.
                bullets = { char = "•", hl_group = "ObsidianBullet" },
                external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                -- Replace the above with this if you don't have a patched font:
                -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                reference_text = { hl_group = "ObsidianRefText" },
                highlight_text = { hl_group = "ObsidianHighlightText" },
                tags = { hl_group = "ObsidianTag" },
                block_ids = { hl_group = "ObsidianBlockID" },
            },

            attachments = {
                img_folder = "assets/imgs",
                img_name_func = function()
                    return string.format("Pasted image %s", os.date "%Y%m%d%H%M%S")
                end,
                confirm_img_paste = true,
            },
            open = {
                use_advanced_uri = true,
                func = vim.ui.open,
            },
        },
    },
}
