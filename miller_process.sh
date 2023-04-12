mlr --ijson --omd flatten then cut -r -f '^features.2.properties' ./wx.json | sed  's/features\.2\.properties\.//g'
