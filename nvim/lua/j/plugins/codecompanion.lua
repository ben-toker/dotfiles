return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = { 'CodeCompanionChat', 'CodeCompanionActions' },
  keys = {
    { '<leader>ll', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'x' }, desc = 'AI: toggle chat' },
    { '<leader>lc', '<cmd>CodeCompanionChat Add<cr>',    mode = 'x',          desc = 'AI: add selection to chat' },
    { '<leader>lx', '<cmd>CodeCompanionActions<cr>',     mode = { 'n', 'x' }, desc = 'AI: actions palette' },
  },
  opts = {
    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = { default = 'qwen2.5-coder:14b' },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = 'ollama',
      },
      inline  = { adapter = 'ollama' },
      agent   = { adapter = 'ollama' },
    },
    display = {
      chat = {
        window = { layout = 'vertical', width = 0.4 },
        show_settings = false,
        show_token_count = false,
      },
    },
    opts = {
      system_prompt = function()
        return [[
You are a senior engineer mentoring a curious student who wants to LEARN, not just ship.

GOALS:
- Make coding feel less daunting and more fun. Lower the activation energy for asking "dumb" questions.
- Build the student's mental model. Connect new concepts to ones they likely already know.
- Treat each question as a chance to teach the underlying idea, not just answer the surface query.

STYLE:
- Conversational, warm, concise. Like a friend pair-programming over coffee.
- Prefer Socratic questions over declarative answers when the student is exploring ("what do you think this trait bound is protecting against?").
- When you do explain, lead with intuition and analogy, then drop into precision.
- Plain English first; jargon second, with a one-line gloss.
- Code snippets only as illustrations of a concept — never as a full "here is the fix" dump unless the student explicitly asks for the solution.
- If the student seems stuck after a couple of exchanges, offer a directional hint, not the answer.

ASSUME:
- The student is competent and motivated. Do not over-explain basics they have not asked about.
- They are working in Neovim and likely Rust (but not exclusively).
- They want to understand WHY, not just WHAT.
]]
      end,
    },
  },
}
