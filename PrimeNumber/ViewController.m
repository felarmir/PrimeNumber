//
//  ViewController.m
//  PrimeNumber
//
//  Created by Denis Andreev on 05/10/2017.
//  Copyright © 2017 Denis Andreev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

BOOL isShow = true;
long long startNumber = 1000000000000000000;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self primeNumberCalculator];
}

- (void) primeNumberCalculator {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		for (long long i = startNumber; i <= LONG_MAX; i++) {
			if([self prime:i]) {
				dispatch_async(dispatch_get_main_queue(), ^{
					_numberLabel.text = [NSString stringWithFormat:@"%lld", i];
				});
			}
			[NSThread sleepForTimeInterval:0.005f];
		}
	});
}

// === Для более быстрого перебора
- (bool)prime:(long long) x{
	if(x == 2)
		return true;
	srand(time(NULL));
	for(int i=0;i<100;i++){
		long long a = (rand() % (x - 2)) + 2;
		if ([self gcd:a b:x] != 1)
			return false;
		if( [self pows:a b:x-1 m:x] != 1)
			return false;
	}
	return true;
}

// быстрое возведение в степень по модулю
-(long long) pows:(long long) a b:(long long) b  m:(long long) m{
	if(b==0)
		return 1;
	if(b%2==0){
		long long t = [self pows:a b:b/2 m:m];
		return [self mul:t b:t m:m] % m;
	}
	return ( [self mul:[self pows:a b:b-1 m:m] b:a m:m]) % m;
}

-(long long)mul:(long long) a b:(long long) b m:(long long) m {
	if(b==1)
		return a;
	if(b%2==0){
		long long t = [self mul:a b:b/2 m:m];
		return (2 * t) % m;
	}
	return ([self mul:a b:b-1 m:m] + a) % m;
}

// Наибольший общий делитель
- (long long) gcd:(long long) a b:(long long) b {
	if(b==0)
		return a;
	return [self gcd:b b:a%b];
}
// ==== end

- (IBAction)hideShowAction:(UIButton*)sender {
	if (!isShow) {
		isShow = true;
		[self boxAnimation:1.0f];
		[_hideShowButton setTitle:@"Hide" forState:UIControlStateNormal];
	} else {
		isShow = false;
		[self boxAnimation:0.0f];
		[_hideShowButton setTitle:@"Show" forState:UIControlStateNormal];
	}
}

// анимация
-(void)boxAnimation:(CGFloat) alpha {
	[UIView animateWithDuration:1.0 delay:1 options:UIViewAnimationOptionCurveLinear animations:
	 ^(void){
		 [_blackBox setAlpha:alpha];
		 CABasicAnimation *rotate;
		 rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
		 rotate.toValue = [NSNumber numberWithFloat:M_PI * 2];
		 rotate.duration = 1;
		 rotate.cumulative = YES;
		 rotate.repeatCount = 2;
		 [_blackBox.layer addAnimation:rotate forKey:@"rotationAnimation"];
	 }
	 completion:^(BOOL finished){}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
