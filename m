Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D71673142
	for <lists+linux-block@lfdr.de>; Thu, 19 Jan 2023 06:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjASFjA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Jan 2023 00:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjASFi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 00:38:58 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099A012A;
        Wed, 18 Jan 2023 21:38:57 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F376667373; Thu, 19 Jan 2023 06:38:52 +0100 (CET)
Date:   Thu, 19 Jan 2023 06:38:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>
Subject: Re: [PATCH v3 8/9] scsi: core: Set BLK_SUB_PAGE_SEGMENTS for small
 max_segment_size values
Message-ID: <20230119053852.GA16933@lst.de>
References: <20230118225447.2809787-1-bvanassche@acm.org> <20230118225447.2809787-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118225447.2809787-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (shost->max_segment_size && shost->max_segment_size < PAGE_SIZE)
> +		blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, q);

Independ of me really not wanting this code at all if we can avoid it:
this has no business in the SCSI midlayer or drivers.  Once the config
option is enabled, setting the flag should happen inside
blk_queue_max_segment_size.
