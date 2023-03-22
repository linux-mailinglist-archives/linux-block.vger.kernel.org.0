Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35AE6C44D1
	for <lists+linux-block@lfdr.de>; Wed, 22 Mar 2023 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCVIXU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Mar 2023 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCVIXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:23:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E6B743
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:23:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A30E868C7B; Wed, 22 Mar 2023 09:23:10 +0100 (CET)
Date:   Wed, 22 Mar 2023 09:23:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322082310.GA22782@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 05:23:49PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This is for mostly for testing purposes.

I have to admit I'd rather not merge this upstream.  Any good reason
why we'd absolutely would want to have it?
