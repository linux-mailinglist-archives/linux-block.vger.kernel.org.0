Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4A19C034
	for <lists+linux-block@lfdr.de>; Thu,  2 Apr 2020 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbgDBLcO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Apr 2020 07:32:14 -0400
Received: from charlie.dont.surf ([128.199.63.193]:56568 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgDBLcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Apr 2020 07:32:14 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 07:32:14 EDT
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 23AE7BF422;
        Thu,  2 Apr 2020 11:25:17 +0000 (UTC)
Date:   Thu, 2 Apr 2020 13:25:09 +0200
From:   Klaus Birkelund Jensen <its@irrelevant.dk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Klaus Jensen <k.jensen@samsung.com>, linux-block@vger.kernel.org,
        osandov@fb.com
Subject: Re: [PATCH blktests] common/fio: do not use norandommap with verify
Message-ID: <20200402112458.bpcadafgkqf6eq6j@apples.localdomain>
References: <CGME20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81@eucas1p2.samsung.com>
 <20200130084941.60943-1-k.jensen@samsung.com>
 <20200203214320.GB1025074@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200203214320.GB1025074@vader>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb  3 13:43, Omar Sandoval wrote:
> On Thu, Jan 30, 2020 at 09:49:41AM +0100, Klaus Jensen wrote:
> > As per the fio documentation, using norandommap with an async I/O engine
> > and I/O depth > 1, can cause verification errors.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> 
> Good catch, applied. Thanks!

Hi Omar,

Looks like this got lost somewhere?


Klaus
