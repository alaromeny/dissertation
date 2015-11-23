/**********************************
 * Author: Siobhan Duncan
 * Title: Array Addition Experiment
 * Last edited: 13/11/2015
 * Description
 * ------------------
 * From Cray's Chapel tutorials 'Data Parallelism, by example'
 * Given n-elements vectors A,B and C and constant alpha,
 * compute A=B+(alpha*C)
 *
***********************************/
use Time;
use CyclicDist;
use BlockDist;



config const n = 500;
config const alpha = 4;

const ProblemSpace = {1..n};
const BlockProblemSpace = {1..n} dmapped Block(boundingBox=ProblemSpace);
const CyclicProblemSpace = {1..n} dmapped Cyclic;


var A,B,C: [CyclicProblemSpace] int;
var X,Y,Z: [BlockProblemSpace] int;

var myTimer: Timer;


forall i in ProblemSpace do{
  A[i] = i;
  B[i] = i;
  C[i] = i;
  X[i] = i;
  Y[i] = i;
  Z[i] = i;
}


//writeln("Initial Array A: ",A);

myTimer.clear();
myTimer.start();

forall i in A do
  A = B + alpha * C;

myTimer.stop();


forall i in A do
  X = Y + alpha * Z;

//writeln("Final Array A: ",A);