Class AOC.Day6 Extends AOC.Common
{

Parameter EASY = {$lb(0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11)};

Parameter HARD = {..#EASY};

/// do ##class(AOC.Day6).DoEasy()
ClassMethod Easy(input As %String = {..#EASY}) As %Integer
{
	set turn = 0
	
	set positions = $lb()
	while $lf(positions, ..Hash(input))=0 {
		set positions = positions _ $lb(..Hash(input))
		set turn = turn + 1
		set input = ..Redistribute(input)			
	}
	set hash =  ..Hash(input)
	set cycle = $ll(positions) - $lf(positions, hash) + 1
	
	zw cycle 
		
	quit turn
}

ClassMethod GetMaxPosition(list As %List) As %Integer
{
	set pos = 0
	set max = 0
	for i=1:1:$ll(list) {
		set:$lg(list, i)>max max=$lg(list, i),pos=i
    }
    quit pos
}

ClassMethod Redistribute(list As %List) As %List
{
	set length = $ll(list)
	set pos = ..GetMaxPosition(list)
	set max = $lg(list, pos)
	set $li(list, pos) = 0
	while max>0 {
		if pos=length {
			set pos = 1
		} else {
			set pos = pos + 1
		}
		
		set max = max - 1
		set $li(list, pos) = $lg(list, pos) + 1
		
    }
    quit list
}

ClassMethod Hash(list As %List) [ CodeMode = expression ]
{
$system.Encryption.Base64Encode($system.Encryption.SHA1Hash(list))
}

/// do ##class(AOC.Day6).DoHard()
ClassMethod Hard(input As %String = {..#EASY}) [ CodeMode = expression ]
{
..DoEasy(input)
}

}

