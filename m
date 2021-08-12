Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928773EA129
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhHLI7u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 04:59:50 -0400
Received: from verein.lst.de ([213.95.11.211]:43476 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235158AbhHLI7t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 04:59:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9677E68AFE; Thu, 12 Aug 2021 10:59:23 +0200 (CEST)
Date:   Thu, 12 Aug 2021 10:59:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH V4 2/7] loop: clean up blkcg association
Message-ID: <20210812085922.GD2867@lst.de>
References: <20210806080302.298297-1-ming.lei@redhat.com> <20210806080302.298297-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806080302.298297-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 06, 2021 at 04:02:57PM +0800, Ming Lei wrote:
>  	return !css || css == blkcg_root_css;
>  }
> +static struct cgroup_subsys_state *loop_rq_blkcg_css(struct loop_cmd *cmd)

Please keep an empty line after each function.
