/**********************************
 * Matrix squaring program
 *
 * Description:
 * ------------
 * This program has been written
 * to test the scaling of chapel's
 * PGAS models. This program tests
 * the Cyclic Distribution on a
 * Matrix
**********************************/

use Time;
use CyclicDist;

var size = 10;

const Space = {1..size,1..size};
const D: domain(2) dmapped Cyclic(startIdx=Space.low) = Space;

var A : [D] real = 4.0;

var myTimer : Timer;

//sets the name of the log file, creates it and opens channel to write to it
var filename: string = "programs/dissertation/matrixSquaring/testingLog.txt";
var myFile = open(filename, iomode.cw);
var myWritingChannel = myFile.writer();


writeln("Before:");
writeln(A);

myTimer.clear();
myTimer.start();
forall (i,j) in Space do{

	A[i,j] = A[i,j] * A[i,j];

	myWritingChannel.write("Element: ", (i,j), " owned by local ", here.id, " of ", numLocales, "\n");

	}
myTimer.stop();




writeln("After:");
writeln(A);
