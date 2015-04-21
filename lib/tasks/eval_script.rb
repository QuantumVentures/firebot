def eval_script(file_contents, arguments)
  proc = Proc.new {}
  method = eval file_contents, proc.binding
  eval "method.to_s(#{arguments})"
end
