options = [
  undefined_division_by_zero_error_module:
    Code.ensure_compiled(StackUnderflow.Exception.DivisionByZeroError) == {:error, :nofile},
  undefined_stack_underflow_error_module:
    Code.ensure_compiled(StackUnderflow.Exception.StackUnderflowError) == {:error, :nofile},
  undefined_struct_division_by_zero_error_exception:
    not function_exported?(StackUnderflow.Exception.DivisionByZeroError, :__struct__, 0),
  undefined_struct_stack_underflow_error_exception:
    not function_exported?(StackUnderflow.Exception.StackUnderflowError, :__struct__, 0)
]

ExUnit.start(options)
