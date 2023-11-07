CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

#check if student-submission files exist
if ! [[ -f student-submission/ListExamples.java ]]
then
    echo "files not found"
    exit
fi

cp student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

cd grading-area

javac -cp $CPATH ListExamples.java

if [[ $? -ne 0 ]]
then
    echo "student file didn't compile."
    exit
fi

javac -cp $CPATH TestListExamples.java

if [[ $? -ne 0 ]]
then
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > ../output.txt

if [[ `grep "OK (2 tests)" ../output.txt` == "OK (2 tests)" ]]
then
    echo "Passed!"
else
    echo "Failed"
    grep "Tests run" ../output.txt
fi





