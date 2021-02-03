#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CKLabelComponent.h"
#import "CKTextComponent.h"
#import "CKTextComponentLayer.h"
#import "CKTextComponentLayerHighlighter.h"
#import "CKTextComponentView.h"
#import "CKTextComponentViewControlTracker.h"
#import "CKTextComponentViewInternal.h"
#import "ComponentTextKit.h"
#import "CKTextKitAttributes.h"
#import "CKTextKitContext.h"
#import "CKTextKitEntityAttribute.h"
#import "CKTextKitRenderer+Positioning.h"
#import "CKTextKitRenderer+TextChecking.h"
#import "CKTextKitRenderer.h"
#import "CKTextKitRendererCache.h"
#import "CKTextKitShadower.h"
#import "CKTextKitTailTruncater.h"
#import "CKTextKitTruncating.h"
#import "CKAsyncLayer.h"
#import "CKAsyncLayerInternal.h"
#import "CKAsyncLayerSubclass.h"
#import "CKAsyncTransaction.h"
#import "CKAsyncTransactionContainer+Private.h"
#import "CKAsyncTransactionContainer.h"
#import "CKAsyncTransactionGroup.h"
#import "CKCacheImpl.h"
#import "CKFunctor.h"
#import "CKHighlightOverlayLayer.h"

FOUNDATION_EXPORT double ComponentTextKitVersionNumber;
FOUNDATION_EXPORT const unsigned char ComponentTextKitVersionString[];

