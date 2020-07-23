
vv=$(ls | grep \\-vv\\-)
vh=$(ls | grep \\-vh\\-)
WORKING_DIR=test
if [ -d "$WORKING_DIR" ]; then rm -Rf $WORKING_DIR; fi

mkdir $WORKING_DIR
cd $WORKING_DIR

gdalwarp -ot Float32 -ts 1500 1000 ../$vv s1a-iw-grd-vv-20200721t010627-20200721t010652-033546-03e31f-001-warp.tiff
gdalwarp -ot Float32 -ts 1500 1000 ../$vh s1a-iw-grd-vh-20200721t010627-20200721t010652-033546-03e31f-002-warp.tiff

gdal_calc.py --type Float32 -A s1a-iw-grd-vh-20200721t010627-20200721t010652-033546-03e31f-002-warp.tiff --calc="A*A" --outfile=int-vh.tiff
gdal_calc.py --type Float32 -A s1a-iw-grd-vv-20200721t010627-20200721t010652-033546-03e31f-001-warp.tiff --calc="A*A" --outfile=int-vv.tiff
gdal_calc.py --type Float32 -A int-vv.tiff -B int-vh.tiff --calc="A/B" --outfile=ratio.tiff

gdal_translate -scale 1 50000 -ot Byte int-vh.tiff int-vhs.tiff
gdal_translate -scale 1 700000 -ot Byte int-vv.tiff int-vvs.tiff
gdal_translate -scale 0 20 -ot Byte ratio.tiff ratios.tiff


gdalbuildvrt -separate rgb.vrt int-vvs.tiff int-vhs.tiff ratios.tiff

gdal_translate -of PNG rgb.vrt output.png