
#import "RNCustomKeyboard.h"
#import "RCTBridge+Private.h"
#import "RCTUIManager.h"

@implementation RNCustomKeyboard

@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE(CustomKeyboard)

RCT_EXPORT_METHOD(install:(nonnull NSNumber *)reactTag withType:(nonnull NSString *)keyboardType)
{
  UIView* inputView = [[RCTRootView alloc] initWithBridge:((RCTBatchedBridge *)_bridge).parentBridge moduleName:@"CustomKeyboard" initialProperties:
    @{
      @"tag": reactTag,
      @"type": keyboardType
    }
  ];

  UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];

  view.inputView = inputView;
  [view reloadInputViews];
}

RCT_EXPORT_METHOD(uninstall:(nonnull NSNumber *)reactTag)
{
  UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];

  view.inputView = nil;
  [view reloadInputViews];
}

RCT_EXPORT_METHOD(insertText:(nonnull NSNumber *)reactTag withText:(NSString*)text) {
  UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];

  [view replaceRange:view.selectedTextRange withText:text];
}

RCT_EXPORT_METHOD(backSpace:(nonnull NSNumber *)reactTag) {
  UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];

  UITextRange* range = view.selectedTextRange;
  if ([view comparePosition:range.start toPosition:range.end] == 0) {
    range = [view textRangeFromPosition:[view positionFromPosition:range.start offset:-1] toPosition:range.start];
  }
  [view replaceRange:range withText:@""];
}

RCT_EXPORT_METHOD(doDelete:(nonnull NSNumber *)reactTag) {
  UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];

  UITextRange* range = view.selectedTextRange;
  if ([view comparePosition:range.start toPosition:range.end] == 0) {
    range = [view textRangeFromPosition:range.start toPosition:[view positionFromPosition: range.start offset: 1]];
  }
  [view replaceRange:range withText:@""];
}

RCT_EXPORT_METHOD(moveLeft:(nonnull NSNumber *)reactTag) {
  UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];

  UITextRange* range = view.selectedTextRange;
  UITextPosition* position = range.start;

  if ([view comparePosition:range.start toPosition:range.end] == 0) {
    position = [view positionFromPosition: position, offset: -1];
  }

  view.selectedTextRange = [view textRangeFromPosition: position toPosition:position];
}

RCT_EXPORT_METHOD(moveRight:(nonnull NSNumber *)reactTag) {
  UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];

  UITextRange* range = view.selectedTextRange;
  UITextPosition* position = range.end;

  if ([view comparePosition:range.start toPosition:range.end] == 0) {
    position = [view positionFromPosition: position, offset: 1];
  }

  view.selectedTextRange = [view textRangeFromPosition: position toPosition:position];
}

RCT_EXPORT_METHOD(switchSystemKeyboard:(nonnull NSNumber*) reactTag) {
  UITextView *view = [_bridge.uiManager viewForReactTag:reactTag];
  UIView* inputView = view.inputView;
  view.inputView = nil;
  [view reloadInputViews];
  view.inputView = inputView;
}

@end
  