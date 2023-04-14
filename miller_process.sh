# mlr --ijson --omd flatten then cut -r -f '^features.2.properties' ./wx.json | sed  's/features\.2\.properties\.//g'
mlr --c2m rename -g -r '^features.2.properties.,' ./wx.csv
#mlr --c2p cat ./wx.csv