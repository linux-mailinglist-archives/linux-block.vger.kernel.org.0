Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13961B36D5
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 07:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDVF3z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Apr 2020 01:29:55 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50042 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgDVF3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 01:29:54 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 3305DBFA60;
        Wed, 22 Apr 2020 05:29:53 +0000 (UTC)
Date:   Wed, 22 Apr 2020 07:29:49 +0200
From:   Klaus Birkelund Jensen <its@irrelevant.dk>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v2] Fix unintentional skipping of tests
Message-ID: <20200422052949.z4pcqzhvgtpaqmhl@apples.localdomain>
References: <20200421073321.92302-1-its@irrelevant.dk>
 <20200422011250.bsl5epjclhri4fqd@shindev.dhcp.fujisawa.hgst.com>
 <20200422051300.w2efeam752fa56ew@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422051300.w2efeam752fa56ew@apples.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 22 07:13, Klaus Birkelund Jensen wrote:
> On Apr 22 01:12, Shinichiro Kawasaki wrote:
> > On Apr 21, 2020 / 09:33, Klaus Jensen wrote:
> > >  
> > > -device_requires() {
> > > -	! _test_dev_is_zoned || _have_fio_zbd_zonemode
> > > -}
> > > -
> > >  test_device() {
> > >  	echo "Running ${TEST_NAME}"
> > >  
> > > @@ -25,6 +21,10 @@ test_device() {
> > >  	local zbdmode=""
> > >  
> > >  	if _test_dev_is_zoned; then
> > > +		if ! _have_fio_zbd_zonemode; then
> > > +			return
> > > +		fi
> > > +
> > 
> > This check is equivalent to device_requires() you removed, isn't it?
> > If the skip check in test_device() is the last resort, it would be the
> > better to check in device_requires(), I think.
> > 
> 
> I did fix something... just not the real problem I think.
> 
> Negations doesnt really work well in device_requires. If changed to
> 
>     ! _require_test_dev_is_zoned || _have_fio_zbd_zonemode
> 
> then, for non-zoned devices, even though device_requires returns 0,
> SKIP_REASON ends up being set to "is not a zoned block device" and skips
> the test in _call_test due to this.
> 
> There are two fixes; either we add a _require_test_dev_is_not_zoned
> again or put the negated check in an arithmetic context, that is
> 
>     (( !_require_test_dev_is_zoned )) || _have_fio_zbd_zonemode
> 
> I think the second option is a hack, so we'd better go with the first
> choice.

Doh.

The _is_not_zoned version would of course just cause the test to be
skipped for zoned devices instead.

So I actually think my original fix is the best option here.
