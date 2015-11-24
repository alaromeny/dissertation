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

//This is both the depth and width of our Matrix. (I kept it square for simplicity)
config const size = 10;


//These are the domains required to specify the Matrix size and distribution
const Space = {1..size,1..size};
const D: domain(2) dmapped Cyclic(startIdx=Space.low) = Space;
var A : [D] real = 4.0;

config const r = 1000;//set to r for easy command line passing.
const repeat = {1..r};

var myTimer : Timer; //The timer module used to time the execution

//sets the name of the log file, creates it and opens channel to write to it


//var filename: string = "/home/ce4/sd246/dissertation/dissertation/matrixSquaring/logs/log_" +size+"_"+ numLocales+".txt"; //for MACS


var filename: string = "/home/sduncan/dissertation/matrixSquaring/logs/log_" +size+"_"+ numLocales+".txt"; //forcluster

var myFile = open(filename, iomode.cw);
var myWritingChannel = myFile.writer();

	for i in repeat{
		//Clears and then starts our timer
		myTimer.clear();
		myTimer.start();


		forall (i,j) in Space do{
			A[i,j] = A[i,j] * A[i,j];
			}


		//stop the timer and read the time elapsed
		myTimer.stop();
		var timeTaken = myTimer.elapsed();


		myWritingChannel.writeln(timeTaken, ", ",  size, ", ", numLocales);
	}