var error:NSError?
        var json:Dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as NSDictionary
        if (error) {
            
        }
