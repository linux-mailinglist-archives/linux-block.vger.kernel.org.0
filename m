Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C61AD77F
	for <lists+linux-block@lfdr.de>; Fri, 17 Apr 2020 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgDQHfP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Apr 2020 03:35:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:41824 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgDQHfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 03:35:15 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 13A07BF493;
        Fri, 17 Apr 2020 07:35:13 +0000 (UTC)
Date:   Fri, 17 Apr 2020 09:35:09 +0200
From:   Klaus Birkelund Jensen <its@irrelevant.dk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Fix unintended skipping of tests
Message-ID: <20200417073509.3j6evbnu54ojfwi2@apples.localdomain>
References: <20200414221151.449946-1-its@irrelevant.dk>
 <20200416214428.GD701157@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416214428.GD701157@vader>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 16 14:44, Omar Sandoval wrote:
> On Wed, Apr 15, 2020 at 12:11:51AM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
> > handful of tests in the block group.
> > 
> > For example, block/005 uses _test_dev_is_rotational to check if the
> > device is rotational and uses the result to size up the fio run. As a
> > side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
> > commit cd11d001fe86) causes the test to print out a "[not run]" even
> > through the test actually ran successfully.
> 
> Oof, I thought I checked for this sort of thing, but clearly I missed
> this one. It might be better to rename the existing helpers _require_foo
> (e.g., _require_test_dev_is_rotational), and have the variant without
> the _require whenever it's needed. Would you mind writing a patch for
> that?
> 

Sounds good to me. I'll whip that up :)


K
