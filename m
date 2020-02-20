Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BAF165B17
	for <lists+linux-block@lfdr.de>; Thu, 20 Feb 2020 11:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBTKFn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Feb 2020 05:05:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726501AbgBTKFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 05:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582193142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2RMcYwQgudYqjYYccg7JsynjQ/G0ZDTFVnVDduOPyA=;
        b=fVgJ6sW35McZqh3HiOgso8OL7fC32ifQxGtvyuMN5kl2WdWGBsOQG8RYifR8GUZlGT4IS+
        ydXP1M4vy0qUDPHsRK6slEmDFd+gy3holij/jks2/H7DqzHoHUSqCkF/HyF3n0F7mFbsDS
        f2/I4XTot4HqidZuih5Dywi2h4wn3uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-ihU8sgVjPsqqid6wA3hlvg-1; Thu, 20 Feb 2020 05:05:38 -0500
X-MC-Unique: ihU8sgVjPsqqid6wA3hlvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59138802590;
        Thu, 20 Feb 2020 10:05:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 434308B561;
        Thu, 20 Feb 2020 10:05:28 +0000 (UTC)
Date:   Thu, 20 Feb 2020 18:05:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
Message-ID: <20200220100524.GA31206@ming.t460p>
References: <20200220024441.11558-1-bvanassche@acm.org>
 <20200220024441.11558-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220024441.11558-3-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 19, 2020 at 06:44:35PM -0800, Bart Van Assche wrote:
> blk_mq_map_queues() and multiple .map_queues() implementations expect that
> set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware

Only single queue mapping expects set->map[HCTX_TYPE_DEFAULT].nr_queues
to be set->nr_hw_queues. For multiple mapping, set->nr_hw_queues should
be sum of each mapping's nr_queue.


Thanks, 
Ming

