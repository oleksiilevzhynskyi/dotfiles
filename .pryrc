p "Helloooooooo from #{__FILE__}!!!"
if defined?(PryDebugger)
  Pry.commands.alias_command 'cc', 'continue'
  Pry.commands.alias_command 'ss', 'step'
  Pry.commands.alias_command 'nn', 'next'
  Pry.commands.alias_command 'ff', 'finish'
  Pry.commands.alias_command 'l=', 'whereami'
end
