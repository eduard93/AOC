Class AOC.Day3 Extends AOC.Common
{

Parameter EASY = 312051;

Parameter HARD = {..#EASY};

Parameter DIRECTIONS = {$lb($lb(1,0), $lb(0,1), $lb(-1,0), $lb(0,-1))};

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
ClassMethod Hard(input As %String = {..#EASY}, verbose As %Boolean = {$$$NO})
{
	kill %field

	set x = 0
	set y = 0
	set %field(x, y) = 1
	
	set direction = $lg(..#DIRECTIONS, 1)
	
	while $g(sum,0)<=input {
		set sum = ..SetNext(.x, .y, .direction)
		w:verbose !, $$$FormatText("x: %1, y: %2, sum: %3", x, y, sum)
	}
	

    quit sum
}

ClassMethod SetNext(ByRef x As %Integer, ByRef y As %Integer, ByRef direction) As %Integer
{
	if (($SYSTEM.SQL.ABS(x)=$SYSTEM.SQL.ABS(y)) && (direction'=$lb(1,0))) {
		do ..ChangeDirection(.direction)
	} elseIf ((direction=$lb(1,0)) && ($SYSTEM.SQL.ABS(x)=($SYSTEM.SQL.ABS(y)+1))) {
		do ..ChangeDirection(.direction)
	}
	
	set x = x + $lg(direction, 1)
	set y = y + $lg(direction, 2)
	set sum = ..GetNeighboursSum(x, y)
	set %field(x, y) = sum
	quit sum
}

ClassMethod ChangeDirection(ByRef direction)
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
	if $data(%field(x-1,y),n2)
	if $data(%field(x-1,y+1),n3)
	if $data(%field(x,y-1),n4)
	if $data(%field(x,y+1),n5)
	if $data(%field(x+1,y-1),n6)
	if $data(%field(x+1,y),n7)
	if $data(%field(x+1,y+1),n8)
	q $g(n1, 0) + $g(n2, 0) + $g(n3, 0) + $g(n4, 0) + $g(n5, 0) + $g(n6, 0) + $g(n7, 0) + $g(n8, 0)
}

}

