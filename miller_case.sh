mlr --c2p put 'if ($Wind_Speed == "0") {$Wind = "None"} 
    elif ($Wind_Speed < 4) {$Wind = "Moderate"}
    elif ($Wind_Speed < 10) {$Wind = "Breezy"}  
    elif ($Wind_Speed > 10) {$Wind = "Hurricane"} 
    else {$Wind = "Some"}' then 
    stats1 -a count -g Wind 
    head  ./sample_wx_cover_date.csv