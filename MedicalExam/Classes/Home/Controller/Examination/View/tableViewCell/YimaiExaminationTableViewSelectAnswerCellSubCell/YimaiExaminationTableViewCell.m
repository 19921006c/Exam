//
//  YimaiExaminationTableViewCell.m
//  DoctorPlatForm
//
//  Created by J on 16/5/10.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationTableViewCell.h"
#import "YimaiExaminationAnswerModel.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "PhotoView.h"
#import "PhotoContainer.h"
#import "UIImageView+YYWebImage.h"
@interface YimaiExaminationTableViewCell ()<ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, strong) PhotoContainer *photoC;

@property (nonatomic, strong) NSMutableArray *arrUrl;

//@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end

@implementation YimaiExaminationTableViewCell

static NSString *const identifier = @"YimaiExaminationTableViewCell";

+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    YimaiExaminationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.answerLabelView.shouldDrawImages = NO;
        cell.answerLabelView.shouldDrawLinks = NO;
        cell.answerLabelView.textDelegate = cell;
    }
    
    return cell;
}

- (void)setSelect_answer_model:(YimaiExaminationAnswerModel *)select_answer_model
{
    _select_answer_model = select_answer_model;
    
    [self setCoreTextString:select_answer_model.answer textView:self.answerLabelView];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"hittest---%@--%@",NSStringFromCGPoint(point),event);
//    NSLog(@"self.answer----%@",NSStringFromCGRect(self.answerLabelView.frame));
//    NSLog(@"super.--------%@",[super hitTest:point withEvent:event]);
//    NSLog(@"self----------%@",self);
    return self;
}

- (void)setCoreTextString:(NSString *)coreTextString textView:(DTAttributedTextView *)textView
{
    NSData *data = [coreTextString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //
    //    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    //
    //    NSRange range = NSMakeRange(0, coreTextString.length - 4);
    //
    //    [attributedString addAttributes:dic range:range];
    //
    //    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    //
    //    dic2[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    //
    //    range = NSMakeRange(coreTextString.length - 4, 4);
    //
    //    [attributedString addAttributes:dic2 range:range];
    
    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
    CGRect maxRect = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_HEIGHT_UNKNOWN);
    NSRange entireString = NSMakeRange(0, [attributedString length]);
    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:maxRect range:entireString];
    CGSize sizeNeeded = [layoutFrame frame].size;
    CGRect frame = CGRectMake(0.0, 0.0, sizeNeeded.width,sizeNeeded.height);
    textView.frame = frame;
    textView.attributedString = attributedString;
}


#pragma mark Custom Views on Text
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        // if the attachment has a hyperlinkURL then this is currently ignored
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        // sets the image if there is one
        imageView.image = [(DTImageTextAttachment *)attachment image];
        // url for deferred loading
        
        imageView.url = attachment.contentURL;
        [imageView setImageWithURL:attachment.contentURL placeholder:[UIImage imageNamed:@"examDefaultImageMax"] options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
        
        [self.arrUrl addObject:imageView.url];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
        
        [imageView addGestureRecognizer:tap];
        
        imageView.userInteractionEnabled = YES;
        
        //        FLOG(@"imageview = %@", imageView.url);
        return imageView;
    }
    return nil;
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap
{
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    //pickerBrowser.toView = btn;
    pickerBrowser.delegate = self;
    pickerBrowser.dataSource = self;
    pickerBrowser.editing = NO;
    pickerBrowser.currentIndexPath = 0;
    [[CommonTool findNearsetViewController:self] presentViewController:pickerBrowser animated:NO completion:nil];
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDataSource>
- (NSInteger)numberOfSectionInPhotosInPickerBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser{
    
    return 1;
}
- (NSInteger)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    
    return self.arrUrl.count;
}

#pragma mark - 每个组展示什么图片,需要包装下ZLPhotoPickerBrowserPhoto
- (ZLPhotoPickerBrowserPhoto *) photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    // id imageObj = [[self.arrUrl objectAtIndex:indexPath.row] fullScreenImage];
    ZLPhotoAssets *imageObj = [self.arrUrl objectAtIndex:indexPath.row];
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:imageObj];
    PhotoView *photview = self.photoC.subviews[indexPath.row];
    photo.toView = photview;
    photo.photoImage = photview.image;
    return photo;
}
#pragma mark - DTLazyImageViewDelegate

//- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
//    NSURL *url = lazyImageView.url;
//    CGSize imageSize = size;
//
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
//
//    BOOL didUpdate = NO;
//
//    // update all attachments that match this URL (possibly multiple images with same size)
//    for (DTTextAttachment *oneAttachment in [_contentLabelView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
//    {
//        // update attachments that have no original size, that also sets the display size
//        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
//        {
//            oneAttachment.originalSize = imageSize;
//
//            didUpdate = YES;
//        }
//
//    }
//    if (didUpdate)
//    {
//        // layout might have changed due to image sizes
//        [_contentLabelView relayoutText];
//    }
//}

- (NSMutableArray *)arrUrl
{
    if (!_arrUrl) {
        _arrUrl = [NSMutableArray array];
    }
    return _arrUrl;
}

@end
