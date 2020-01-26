//
//  MQViewController.m
//  MusicQuery
//
//  Created by Matt Jones on 10/3/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "MQViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MQViewController ()
@property (nonatomic, weak) IBOutlet UITextView *console;
@property (nonatomic, strong) NSMutableDictionary *artists;
@end

@implementation MQViewController

- (NSMutableDictionary *)artists {
    if (!_artists) {
        _artists = [NSMutableDictionary new];
    }
    return _artists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.console.backgroundColor = [UIColor clearColor];
    self.console.font = [UIFont fontWithName:@"Courier" size:10.0f];
    self.console.textColor = [UIColor greenColor];
    self.console.editable = NO;
    self.console.selectable = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.console.text = @"";
    [self analyze];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)log:(NSString *)info {
    [self log:info newline:YES];
}

- (void)log:(NSString *)info newline:(BOOL)newline {
    NSLog(@"%@", info);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.console.text = [NSString stringWithFormat:@"%@%@%@",
                             self.console.text, (newline ? @"\n" : @""), info];
        NSRange range = NSMakeRange([self.console.text length] - 2, 1);
        [self.console scrollRangeToVisible:range];
    });
}

- (void)analyze {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0ul);
    dispatch_async(queue, ^{
        MPMediaQuery *everything = [MPMediaQuery songsQuery];
        NSArray *items = [everything items];
        [self log:[NSString stringWithFormat:@"Analyzing %d songs... ", [items count]]];
        NSDate *start = [NSDate date];
        
        for (MPMediaItem *song in items) {
            NSString *artist = [song valueForProperty:MPMediaItemPropertyArtist];
            NSNumber *count = [song valueForProperty:MPMediaItemPropertyPlayCount];
            NSNumber *rating = [song valueForProperty:MPMediaItemPropertyRating];
            
            if (self.artists[artist]) {
                NSInteger n = [self.artists[artist][@"playCount"] integerValue];
                n += [count integerValue];
                self.artists[artist][@"playCount"] = @(n);
                
                if ([rating integerValue]) {
                    n = [self.artists[artist][@"ratingsCount"] integerValue];
                    n++;
                    self.artists[artist][@"ratingsCount"] = @(n);
                    
                    n = [self.artists[artist][@"ratingsTotal"] integerValue];
                    n += [rating integerValue];
                    self.artists[artist][@"ratingsTotal"] = @(n);
                }
            } else if (artist) {
                self.artists[artist] = [NSMutableDictionary dictionaryWithDictionary:
                                        @{@"artist": artist,
                                          @"playCount": @(0),
                                          @"ratingsCount": @(0),
                                          @"ratingsTotal": @(0)}];
            }
        }
        
        for (NSMutableDictionary *artist in [self.artists allValues]) {
            CGFloat rating = [self artistRating:artist];
            NSInteger playCount = [artist[@"playCount"] integerValue];
            artist[@"rating"] = @(rating);
            artist[@"awesomeIndex"] = @(MAX(1, rating) * MAX(1, playCount));
        }
        
        [self log:[NSString stringWithFormat:@"Finished. (%.3fs)",
                   ABS([start timeIntervalSinceNow])]
          newline:NO];
        [self printTopArtists];
    });
}

- (CGFloat)artistRating:(NSDictionary *)artist {
    NSInteger total = [artist[@"ratingsTotal"] integerValue];
    NSInteger count = [artist[@"ratingsCount"] integerValue];
    
    if (count) {
        return 1.0f * total / count;
    }
    
    return 0.0f;
}

- (void)printTopArtists {
    NSArray *artists = [self.artists allValues];
    NSSortDescriptor *descript = [NSSortDescriptor sortDescriptorWithKey:@"playCount"
                                                               ascending:NO];
    NSArray *byPlayCount = [artists sortedArrayUsingDescriptors:@[descript]];
    
    NSInteger count = 20;
    
    [self log:[NSString stringWithFormat:@"\nTop %d by Play Count:", count]];
    for (NSInteger i=0; i<MIN(count, [byPlayCount count]); i++) {
        NSDictionary *artist = byPlayCount[i];
        [self log:[NSString stringWithFormat:@"\t%2d. %@ (%@)",
                   i+1, artist[@"artist"], artist[@"playCount"]]];
    }
    
    descript = [NSSortDescriptor sortDescriptorWithKey:@"rating"
                                             ascending:NO];
    NSArray *byRating = [artists sortedArrayUsingDescriptors:@[descript]];
    
    [self log:[NSString stringWithFormat:@"\nTop %d by Rating:", count]];
    for (NSInteger i=0; i<MIN(count, [byRating count]); i++) {
        NSDictionary *artist = byRating[i];
        [self log:[NSString stringWithFormat:@"\t%2d. %@ (%.2f)",
                   i+1, artist[@"artist"], [artist[@"rating"] floatValue]]];
    }
    
    descript = [NSSortDescriptor sortDescriptorWithKey:@"awesomeIndex"
                                             ascending:NO];
    NSArray *byAwesomeIndex = [artists sortedArrayUsingDescriptors:@[descript]];
    
    [self log:[NSString stringWithFormat:@"\nTop %d by Awesome Index:", count]];
    for (NSInteger i=0; i<MIN(count, [byAwesomeIndex count]); i++) {
        NSDictionary *artist = byAwesomeIndex[i];
        [self log:[NSString stringWithFormat:@"\t%2d. %@ (%.2f)",
                   i+1, artist[@"artist"], [artist[@"awesomeIndex"] floatValue]]];
    }
}

@end
