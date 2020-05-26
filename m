Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3181B36B8
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 07:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDVFNG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Apr 2020 01:13:06 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50008 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDVFNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 01:13:06 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 56D0BBF5A5;
        Wed, 22 Apr 2020 05:13:04 +0000 (UTC)
Date:   Wed, 22 Apr 2020 07:13:00 +0200
From:   Klaus Birkelund Jensen <its@irrelevant.dk>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v2] Fix unintentional skipping of tests
Message-ID: <20200422051300.w2efeam752fa56ew@apples.localdomain>
References: <20200421073321.92302-1-its@irrelevant.dk>
 <20200422011250.bsl5epjclhri4fqd@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422011250.bsl5epjclhri4fqd@shindev.dhcp.fujisawa.hgst.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 22 01:12, Shinichiro Kawasaki wrote:
> Hello Klaus,
> 

Hi Shinichiro,

Thanks for taking a look.

> Thank you for this patch. I also face the unexpected "not run" messages and this
> patch fixes them. I made a couple of comments on your patch in line.
> 
> On Apr 21, 2020 / 09:33, Klaus Jensen wrote:
> >  
> > +_test_dev_can_discard() {
> > +	if [[ $(cat "${TEST_DEV_SYSFS}/queue/discard_max_bytes") -eq 0 ]]; then
> > +		return 1
> > +	fi
> > +	return 0
> > +}
> > +
> > +_require_test_dev_can_discard() {
> > +	if ! _test_dev_can_discard; then
> > +		SKIP_REASON="$TEST_DEV does not support discard"
> > +		return 1
> > +	fi
> > +	return 0
> > +}
> > +
> 
> Don't we need replace _test_dev_can_discard() in block/003 with
> _require_test_dev_can_discard()?
> 

Thought I got them all... Good catch!

> >  
> > -device_requires() {
> > -	! _test_dev_is_zoned || _have_fio_zbd_zonemode
> > -}
> > -
> >  test_device() {
> >  	echo "Running ${TEST_NAME}"
> >  
> > @@ -25,6 +21,10 @@ test_device() {
> >  	local zbdmode=""
> >  
> >  	if _test_dev_is_zoned; then
> > +		if ! _have_fio_zbd_zonemode; then
> > +			return
> > +		fi
> > +
> 
> This check is equivalent to device_requires() you removed, isn't it?
> If the skip check in test_device() is the last resort, it would be the
> better to check in device_requires(), I think.
> 

I did fix something... just not the real problem I think.

Negations doesnt really work well in device_requires. If changed to

    ! _require_test_dev_is_zoned || _have_fio_zbd_zonemode

then, for non-zoned devices, even though device_requires returns 0,
SKIP_REASON ends up being set to "is not a zoned block device" and skips
the test in _call_test due to this.

There are two fixes; either we add a _require_test_dev_is_not_zoned
again or put the negated check in an arithmetic context, that is

    (( !_require_test_dev_is_zoned )) || _have_fio_zbd_zonemode

I think the second option is a hack, so we'd better go with the first
choice.
