Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F76C4D64
	for <lists+linux-block@lfdr.de>; Wed, 22 Mar 2023 15:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCVOUx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Mar 2023 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjCVOUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 10:20:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019564B19
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 07:20:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3758067373; Wed, 22 Mar 2023 15:20:10 +0100 (CET)
Date:   Wed, 22 Mar 2023 15:20:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322142010.GA18721@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-3-kbusch@meta.com> <20230322082310.GA22782@lst.de> <20230322084651.xmnup2ag3ve6jr3a@carbon.lan> <20230322135200.GA16587@lst.de> <20230322140619.zy2msly7mcuwgo6a@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322140619.zy2msly7mcuwgo6a@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 03:06:19PM +0100, Daniel Wagner wrote:
> On Wed, Mar 22, 2023 at 02:52:00PM +0100, Christoph Hellwig wrote:
> > Who says that we could support polling on all current and future
> > fabrics transports?
> 
> I just assumed this is a generic feature supposed to present in all transports.
> I'll update my new blktest test to run only tcp or rdma.

The best idea would be to do a trival and error, that is do a _notrun
if trying to create a connection with the options fails.
