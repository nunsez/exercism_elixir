defmodule StackUnderflow.ExceptionTest do
  use ExUnit.Case
  doctest StackUnderflow.Exception

  alias StackUnderflow.Exception

  config = ExUnit.configuration()

  # When modules used in the test suite don't exist, or don't implement the desired struct,
  # a compile error occurs.
  # So the test suite is never run, so using the cond to conditionally create test cases based
  # on if the module is defined and loaded, allows for meaningful error messages.

  cond do
    config[:undefined_division_by_zero_error_module] ->
      @tag task_id: 1
      test "DivisionByZeroError defined" do
        flunk("Implement the DivisionByZeroError inside of the `StackUnderflow.Exception` module")
      end

    config[:undefined_division_by_zero_error_exception] ->
      @tag task_id: 1
      test "DivisionByZeroError defined" do
        flunk("define DivisionByZeroError exception using `defexception`")
      end

    true ->
      @tag task_id: 1
      test "DivisionByZeroError fields defined by `defexception`" do
        assert %Exception.DivisionByZeroError{}.__exception__ == true

        assert %Exception.DivisionByZeroError{}.__struct__ ==
          Exception.DivisionByZeroError

        assert %Exception.DivisionByZeroError{}.message ==
          "division by zero occurred"
      end

      @tag task_id: 1
      test "DivisionByZeroError message when raised with raise/1" do
        assert_raise(
          Exception.DivisionByZeroError,
          "division by zero occurred",
          fn ->
            raise Exception.DivisionByZeroError
          end
        )
      end
  end

  cond do
    config[:undefined_stack_underflow_error_module] ->
      @tag task_id: 2
      test "StackUnderflowError defined" do
        flunk("Implement the StackUnderflowError inside of the `StackUnderflow.Exception` module")
      end

    config[:undefined_stack_underflow_error_exception] ->
      @tag task_id: 2
      test "StackUnderflowError defined" do
        flunk("define StackUnderflowError exception using `defexception`")
      end

    true ->
      @tag task_id: 2
      test "StackUnderflowError fields defined by `defexception`" do
        assert %Exception.StackUnderflowError{}.__exception__ == true

        assert %Exception.StackUnderflowError{}.__struct__ ==
          Exception.StackUnderflowError

        assert %Exception.StackUnderflowError{}.message ==
          "stack underflow occurred"
      end

      @tag task_id: 2
      test "StackUnderflowError message when raised with raise/1" do
        assert_raise(
          Exception.StackUnderflowError,
          "stack underflow occurred",
          fn ->
            raise Exception.StackUnderflowError
          end
        )
      end

      @tag task_id: 2
      test "StackUnderflowError message when raised with raise/2" do
        assert_raise(
          Exception.StackUnderflowError,
          "stack underflow occurred, context: test",
          fn ->
            raise Exception.StackUnderflowError, "test"
          end
        )
      end
  end

  describe "divide/1" do
    @tag task_id: 3
    test "when stack doesn't contain any numbers, raise StackUnderflowError" do
      assert_raise(
        Exception.StackUnderflowError,
        "stack underflow occurred, context: when dividing",
        fn ->
          Exception.divide([])
        end
      )
    end

    @tag task_id: 3
    test "when stack contains only one number, raise StackUnderflowError" do
      assert_raise(
        Exception.StackUnderflowError,
        "stack underflow occurred, context: when dividing",
        fn ->
          Exception.divide([3])
        end
      )
    end

    @tag task_id: 3
    test "when stack contains only one number, raise StackUnderflowError, even when it's a zero" do
      assert_raise(
        Exception.StackUnderflowError,
        "stack underflow occurred, context: when dividing",
        fn ->
          Exception.divide([0])
        end
      )
    end

    @tag task_id: 3
    test "when divisor is 0, raise DivisionByZeroError" do
      assert_raise(Exception.DivisionByZeroError, "division by zero occurred", fn ->
        Exception.divide([0, 2])
      end)
    end

    @tag task_id: 3
    test "divisor is not 0, don't raise" do
      assert Exception.divide([2, 4]) == 2
    end
  end
end
