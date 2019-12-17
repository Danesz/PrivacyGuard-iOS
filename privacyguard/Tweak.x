#import <UIKit/UIKit.h>

%hook SpringBoard
-(void) applicationDidFinishLaunching:(id)arg {
	%orig(arg);
	UIAlertView *lookWhatWorks = [[UIAlertView alloc] initWithTitle:@"PrivacyGuard Tweak"
		message:@"Your privacy guard is running 😎"
		delegate:self
		cancelButtonTitle:@"OK"
		otherButtonTitles:nil];
	[lookWhatWorks show];
}
%end

%hook AVCaptureSession

// Hooking an instance method with no arguments.
-(void) startRunning {
	NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
	NSLog(@"PrivacyGuard startRunning: %@", appName);

	UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
	statusBar.backgroundColor = [UIColor greenColor];

	%orig;

}

-(void) stopRunning {
	NSLog(@"PrivacyGuard stopRunning");

	UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
	statusBar.backgroundColor = [UIColor clearColor];

	%orig;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end