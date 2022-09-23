Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0F5E7E2F
	for <lists+linux-block@lfdr.de>; Fri, 23 Sep 2022 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiIWPVm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Sep 2022 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiIWPVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 11:21:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FDA1432B6;
        Fri, 23 Sep 2022 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eaKKTfbFo2P8xEZq4H2g2bWvvmV1VB14/0AR1qRGNAI=; b=rFeSvhRVTADr/j0M4dBPPHzuAB
        OQDoVj/4SwcXAwFKTL7ecPUAgrS9LuaiIaHbV/MDMptdZWUNSm96AVk8e66iDsNdzItdYK2MGDHB5
        mE7+aYcY9XXgbPeTB0QzX3pAhoDOPn+Qd/XTjHcBHJvPJcShy6d6yuQqZ0XQE5njF1Cocm46pOzs/
        E8tQ5aNLNJWuyCfiWoUs18jALhF+ttAxvPIZ3T7q5jkWdh9AoC+zbsi+oF4QSdajAxeK7w1iQiwuJ
        B60CE/+LqZkembUEb5VXTCAYC6awUQNmNKSloI4OOEiPP66+gdw5mJx9JmBhY2kWNYb2oXVE90FQe
        whMxWcgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obkUR-004nB8-4H; Fri, 23 Sep 2022 15:21:19 +0000
Date:   Fri, 23 Sep 2022 08:21:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Message-ID: <Yy3O7wH16t6AhC3j@infradead.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922182805.96173-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	union {
> +		struct {
> +			void *meta; /* kernel-resident buffer */
> +			void __user *meta_buffer;
> +		};
> +		struct {
> +			u32 nvme_flags;
> +			u32 nvme_status;
> +			u64 result;
> +		};
> +	};

Without naming the arms of the union this is becoming a bit too much
of a mess..

> +static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
> +{
> +	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> +	int status;
> +
> +	if (pdu->nvme_flags & NVME_REQ_CANCELLED)
> +		status = -EINTR;
> +	else
> +		status = pdu->nvme_status;

If you add a signed int field you only need one field instead of
two in the pdu for this (the nvme status is only 15 bits anyway).
