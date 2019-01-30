NSURL *url = [NSURL URLWithString: @"http://"];
NSString *body = [NSString stringWithFormat: @"arg1=%@&arg2=%@", @"val1",@"val2"]; NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
[request setHTTPMethod: @"POST"];
[request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
[webView loadRequest: request];