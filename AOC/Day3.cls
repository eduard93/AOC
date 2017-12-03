Class AOC.Day3 Extends AOC.Common
{

Parameter EASY = 312051;

Parameter HARD = {..#EASY};

/// left, up, right, down
Parameter DIRECTIONS = {$lb($lb(1,0), $lb(0,1), $lb(-1,0), $lb(0,-1))};

/// 37  36  35  34  33  32 31       
/// 38  17  16  15  14  13 30
/// 39  18   5   4   3  12 29
/// 40  19   6   1   2  11 28
/// 41  20   7   8   9  10 27
/// 42  21  22  23  24  25 26
/// 43  44  45  46  47  48 49
/// 
/// 3 -  2  4  6  8    9-1
/// 5 - 11 15 19 23   25-2
/// 7 - 28 34 40 46   49-3
/// 
/// do ##class(AOC.Day3).DoEasy()
ClassMethod Easy(input As %String = {..#EASY}) As %Integer
{
	
	set root = input**(1/2)
	set root = $SYSTEM.SQL.CEILING(root)
	
	set level = root + 1 - (root#2)

	
	/// min steps = levelnum
	/// max steps = levelNum * 2
	set levelNum = level \ 2
	
	set corner = (level**2)
	while corner > input {
		set corner = corner - (level - 1)
	}
	set offset = input - corner
	quit (levelNum * 2) - offset
}

/// do ##class(AOC.Day3).DoHard()
ClassMethod Hard(input As %String = {..#HARD}, verbose As %Boolean = {$$$NO})
{
	kill %field

	set sum = 0
	set x = 0
	set y = 0
	set %field(x, y) = 1
	
	set direction = $lg(..#DIRECTIONS, 1)
	
	while sum<=input {
		set sum = ..SetNext(.x, .y, .direction)
		write:verbose !, $$$FormatText("x: %1, y: %2, sum: %3", x, y, sum)
	}
    quit sum
}

ClassMethod SetNext(ByRef x As %Integer, ByRef y As %Integer, ByRef direction As %List) As %Integer
{
	set left = $lg(..#DIRECTIONS, 1)
	if (($zabs(x)=$zabs(y)) && (direction'=left)) {
		do ..ChangeDirection(.direction)
	} elseIf ((direction=left) && ($zabs(x)=($zabs(y)+1))) {
		do ..ChangeDirection(.direction)
	}
	
	set x = x + $lg(direction, 1)
	set y = y + $lg(direction, 2)
	set sum = ..GetNeighboursSum(x, y)
	set %field(x, y) = sum
	quit sum
}

ClassMethod ChangeDirection(ByRef direction As %List)
{
	set pos = $lf(..#DIRECTIONS, direction)
	
	if pos<$ll(..#DIRECTIONS) {
		set pos = pos + 1
	} else {
		set pos = 1
	}
	set direction = $lg(..#DIRECTIONS, pos)
}

ClassMethod GetNeighboursSum(x As %Integer, y As %Integer) As %Integer
{
	if $data(%field(x-1,y-1),n1)
	if $data(%field(x-1,y), n2)
	if $data(%field(x-1,y+1), n3)
	if $data(%field(x,y-1), n4)
	if $data(%field(x,y+1), n5)
	if $data(%field(x+1,y-1), n6)
	if $data(%field(x+1,y), n7)
	if $data(%field(x+1,y+1), n8)
	quit $g(n1, 0) + $g(n2, 0) + $g(n3, 0) + $g(n4, 0) + $g(n5, 0) + $g(n6, 0) + $g(n7, 0) + $g(n8, 0)
}

}

