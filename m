Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA9566519
	for <lists+linux-block@lfdr.de>; Tue,  5 Jul 2022 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiGEIeX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Jul 2022 04:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGEIeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 04:34:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2BA2645;
        Tue,  5 Jul 2022 01:34:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 521C168AA6; Tue,  5 Jul 2022 10:34:16 +0200 (CEST)
Date:   Tue, 5 Jul 2022 10:34:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, agk@redhat.com, song@kernel.org,
        djwong@kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
        jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
        danil.kipnis@cloud.ionos.com, ebiggers@google.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Message-ID: <20220705083416.GA19123@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com> <20220630091406.19624-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 30, 2022 at 02:14:01AM -0700, Chaitanya Kulkarni wrote:
> This adds a new block layer operation to offload verifying a range of
> LBAs. This support is needed in order to provide file systems and
> fabrics, kernel components to offload LBA verification when it is
> supported by the hardware controller. In case hardware offloading is
> not supported then we provide API to emulate the same. The prominent
> example of that is SCSI and NVMe Verify command. We also provide
> an emulation of the same operation that can be used in case H/W does
> not support verify. This is still useful when block device is remotely
> attached e.g. using NVMeOF.

What is the point of providing the offload?
