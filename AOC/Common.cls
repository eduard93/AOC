Class AOC.Common [ Abstract ]
{

ClassMethod DoEasy(args...)
{
	set start = $piece($zts, ",", 2)
	set result = ..Easy(args...)
	set end = $piece($zts, ",", 2)
	
	write !, $$$FormatText("Result: %1", result)
	write !, $$$FormatText("Time: %1 sec.", end - start)
}

ClassMethod DoHard(args...)
{
	set start = $piece($zts, ",", 2)
	set result = ..Hard(args...)
	set end = $piece($zts, ",", 2)
	
	write !, $$$FormatText("Result: %1", result)
	write !, $$$FormatText("Time: %1 sec.", end - start)
}

}

