% Autogenerated with DRAKON Editor 1.26

-module(erldemo).
-export([common_fate/1, fibonacci/1, foreach/2, main/0, quicksort/2]).

back_cmp(X, Y) ->
    % item 168
    case X < Y of true -> 
        % item 169
        1
    ; false ->
        % item 173
        case X > Y of true -> 
            % item 174
            -1
        ; false ->
            % item 175
            0
        end
    end
.

common_fate(X) ->
    % item 279
    case X > 0 of true -> 
        % item 282
        Y = 500
    ; false ->
        % item 283
        Y = 200
    end,
    % item 284
    Y * 7
.

fibonacci(N) ->
    case N of
        0 ->
            % item 218
            [0]
        ;
        1 ->
            % item 219
            [1, 0]
        ;
       _ ->
            % item 220
            [First, Second | Rest] = fibonacci(N - 1),
            % item 221
            Fib = First + Second,
            % item 222
            [Fib, First, Second | Rest]
    end
.

foreach(List, Visitor) ->
    % item 55
    case List == [] of true -> 
        % item 56
        void
    ; false ->
        % item 59
        [ Head | Rest ] = List,
        Visitor(Head),
        % item 60
        foreach(Rest, Visitor)
    end
.

foreach_demo() ->
    % item 49
    io:format("iteration demo~n"),
    % item 42
    FibReversed = fibonacci(20),
    Fibonacci = lists:reverse(FibReversed),
    % item 224
    Visitor = fun(X) -> 
    	print(X)
    end,
    % item 61
    foreach(Fibonacci, Visitor),
    io:format("~n", [])
.

is_sorted(List) ->
    % item 182
    Length = length(List),
    case Length of
        0 ->
            []
        ;
        1 ->
            []
        ;
       _ ->
            % item 191
            [First, Second | Tail] = List,
            % item 192
            Cmp = back_cmp(First, Second),
            % item 193
            case Cmp == 1 of true -> 
                % item 195
                print_list(List),
                throw("List not sorted")
            ; false ->
                % item 196
                is_sorted(Tail)
            end
    end
.

main() ->
    % item 34
    foreach_demo(),
    % item 66
    quicksort_demo()
.

print(Item) ->
    % item 48
    io:format("~w ", [Item])
.

print_list(List) ->
    % item 226
    Visitor = fun(X) -> 
    	io:format("~s ", [X]) 
    end,
    % item 225
    foreach(List, Visitor),
    % item 75
    io:format("~n", [])
.

quicksort(List, Comparer) ->
    % item 121
    Length = length(List),
    case Length of
        0 ->
            % item 157
            Result = List,
            % item 162
            Result
        ;
        1 ->
            % item 157
            Result = List,
            % item 162
            Result
        ;
        2 ->
            % item 158
            [ First, Second | _ ] = List,
            Cmp = Comparer(First, Second),
            % item 159
            case Cmp == -1 of true -> 
                % item 160
                Result = List
            ; false ->
                % item 138
                Result = [Second, First]
            end,
            % item 162
            Result
        ;
       _ ->
            % item 141
            [ Pivot | Others ] = List,
            % item 223
            LessThanPivot = fun(X) ->
            	Comparer(X, Pivot) == -1 
            end,
            % item 198
            {Left, Right} = lists:partition(
            	LessThanPivot,
            	Others
            ),
            % item 155
            LeftSorted = quicksort(Left, Comparer),
            RightSorted = quicksort(Right, Comparer),
            % item 161
            Result = LeftSorted ++ [Pivot] ++ RightSorted,
            % item 162
            Result
    end
.

quicksort_demo() ->
    % item 65
    io:format("quick sort demo~n", []),
    % item 67
    Unsorted = [ "the", "sooner", "we", "start", "this", "the", "better" ],
    Sorted   = [ "aa", "bb", "cc", "dd", "ee", "ff" ],
    Reverse  = [ "ff", "ee", "dd", "cc", "bb", "aa" ],
    Empty    = [],
    Flat     = [ "flat", "flat", "flat", "flat", "flat" ],
    % item 91
    Comparer = fun(X, Y) -> back_cmp(X, Y) end,
    Unsorted2 = quicksort(Unsorted, Comparer),
    Sorted2 = quicksort(Sorted, Comparer),
    Reverse2 = quicksort(Reverse, Comparer),
    Empty2 = quicksort(Empty, Comparer),
    Flat2 = quicksort(Flat, Comparer),
    % item 68
    print_list(Unsorted2),
    print_list(Sorted2),
    print_list(Reverse2),
    print_list(Empty2),
    print_list(Flat2),
    % item 197
    is_sorted(Unsorted2),
    is_sorted(Sorted2),
    is_sorted(Reverse2),
    is_sorted(Empty2),
    is_sorted(Flat2)
.


