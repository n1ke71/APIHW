//
//  VideosController.m
//  APIHW
//
//  Created by Kozaderov Ivan on 27/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "VideosController.h"
#import "ServerManager.h"

@interface VideosController ()
@property (strong ,nonatomic) NSMutableArray *videosArray;
@end

@implementation VideosController

static NSInteger videosInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videosArray = [NSMutableArray array];
    [self getVideosFromServer];
}

#pragma mark - API

- (void) getVideosFromServer {
    
    [[ServerManager sharedManager] getVideosFromWall:@"-58860049"
                                          withOffset:[self.videosArray count] count:videosInRequest onSuccess:^(NSArray * _Nonnull videos) {
                                              [self.videosArray addObjectsFromArray:videos];
                                          } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                              NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
                                          }];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideosCell" forIndexPath:indexPath];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
