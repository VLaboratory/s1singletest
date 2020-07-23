echo "Start" $(date)
echo "Root content"
ls -l
mv s1.sh data/satproduct/measurement
cd data/satproduct/measurement
echo "data/satproduct/measurement content"
ls -l
chmod +x ./s1.sh
echo "data/satproduct/measurement content (s1 should be executabòe)"
ls -l
echo "Computation start" $(date)
./s1.sh
echo "Computation end" $(date)
echo "data/satproduct/measurement content after computation"
ls -l
echo "data/satproduct/measurementtest/ content after computation"
ls -l test/
cp test/output.png ../../preview.png

echo "data/ content after output copy"
ls -l ../../
echo "End" $(date)