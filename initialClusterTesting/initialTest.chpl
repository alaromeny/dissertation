/**********************************
 * Initial Cluster Testing Program
 *
 * Description:
 * ------------
 * This program has been written
 * to try out the locals on the
 * cluster,
**********************************/

use CyclicDist;

var size = 100;

const CyclicProblemSpace = {1..size} dmapped Cyclic(startIdx=1);

//sets the name of the log file, creates it and opens channel to write to it
var filename: string = "/home/sduncan/dissertation/initialTest/testingLog.txt";
var myFile = open(filename, iomode.cw);
var myWritingChannel = myFile.writer();



forall element in CyclicProblemSpace do
	myWritingChannel.write("Element: ", element, " of ", size, " owned by local ", here.id, " of ", numLocales, "\n");