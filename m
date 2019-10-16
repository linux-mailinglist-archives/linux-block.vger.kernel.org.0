Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE6D88A7
	for <lists+linux-block@lfdr.de>; Wed, 16 Oct 2019 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfJPGbo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Oct 2019 02:31:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbfJPGbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 02:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O611cieVSVNt8LUHCPk3HooYF5ljCfjEE1ZZe7y3RI4=; b=QIgRUipKt/34cq141WPjeqe5f
        DCPAFTdNvuB/tF6Tky+qkoLqmz9rwVcjqxYKCQ5BVqtkHgEsiYea8OqYp54NwPTuYu9q63stbZyu9
        hiENMAooSorDR99/xUjLK3f+3fi1aJMQ8EyZ1R14JRHKYDYhaWHJenz6zcpKBzlphHziMHf3jBtR6
        rSMAxmaZWuhj2aA+JZRZIS3l9581zLkFMmyrqLZeHvqC1f9D1C2oBuZTafh+w2D7rAtxl0Y7xnquD
        KvbuSr8xFVElIkyCdNZxTq4/PwTOTTEDUNE6oZf7wqminFbKNpVmUfN4TkBAy71E0u3UJhB7Nz/Bf
        0GLcKDblg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKcqS-00034D-KX; Wed, 16 Oct 2019 06:31:40 +0000
Date:   Tue, 15 Oct 2019 23:31:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/3] block: sed-opal: Expose enum opal_uid and opaluid
Message-ID: <20191016063140.GA6852@infradead.org>
References: <20191015230246.10171-1-revanth.rajashekar@intel.com>
 <20191015230246.10171-2-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015230246.10171-2-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 15, 2019 at 05:02:44PM -0600, Revanth Rajashekar wrote:
> This patch exposes UIDs to UAPI to allow userspace to use the
> UIDs as IOCTL arguments.

No way we'd expose an actual array containing data in the uapi, that
doesn't make any sense.
