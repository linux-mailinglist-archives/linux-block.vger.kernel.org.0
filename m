Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2968A76CC13
	for <lists+linux-block@lfdr.de>; Wed,  2 Aug 2023 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjHBLwq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Aug 2023 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjHBLwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 07:52:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23952720
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 04:52:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 82C0F68AA6; Wed,  2 Aug 2023 13:52:09 +0200 (CEST)
Date:   Wed, 2 Aug 2023 13:52:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v5 3/7] scsi: core: Retry unaligned zoned writes
Message-ID: <20230802115209.GA30175@lst.de>
References: <20230731221458.437440-1-bvanassche@acm.org> <20230731221458.437440-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731221458.437440-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/*
> + * Returns a negative value if @_a has a lower LBA than @_b, zero if
> + * both have the same LBA and a positive value otherwise.
> + */
> +static int scsi_cmp_lba(void *priv, const struct list_head *_a,
> +			const struct list_head *_b)
> +{
> +	struct scsi_cmnd *a = list_entry(_a, typeof(*a), eh_entry);
> +	struct scsi_cmnd *b = list_entry(_b, typeof(*b), eh_entry);
> +	const sector_t pos_a = blk_rq_pos(scsi_cmd_to_rq(a));
> +	const sector_t pos_b = blk_rq_pos(scsi_cmd_to_rq(b));

The SCSI core has no concept of LBAs.  Even assuming something like
this is a good idea (and I'm very doubtful) it would have to live
in sd.c.

