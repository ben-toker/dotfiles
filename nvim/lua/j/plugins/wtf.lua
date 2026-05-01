return {
  'piersolenski/wtf.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    provider = 'ollama',
    providers = {
      ollama = {
        model_id = 'qwen2.5-coder:14b',
      },
    },
    language = 'english',
    popup_type = 'vertical',
    additional_instructions = [[
You are a senior engineer mentoring a student. Your goal is to teach, not to solve.

RULES:
- Do NOT write the fixed code. Do NOT provide a code block with the answer.
- Instead, ask 2-4 guiding questions that lead the student toward understanding the error themselves.
- Each question should probe a specific concept the error depends on (type signatures, control flow, ownership, trait bounds, etc.).
- Briefly explain what the compiler is complaining about in plain English (one or two sentences), but stop short of prescribing the fix.
- If the student appears truly stuck (e.g. asks the same thing twice), you may offer a nudge — a hint about which direction to look — but still not the full answer.
- Prefer Socratic questions over declarative statements. "What type does this branch evaluate to?" beats "This branch returns ()."
]],
  },
  keys = {
    { '<leader>wa', mode = { 'n', 'x' }, function() require('wtf').diagnose() end, desc = 'AI: explain diagnostic' },
    { '<leader>ws', function() require('wtf').search() end,                        desc = 'Search diagnostic online' },
    { '<leader>wh', function() require('wtf').history() end,                       desc = 'WTF history' },
  },
}
