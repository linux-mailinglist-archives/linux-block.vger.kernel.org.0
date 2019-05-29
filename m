Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7E2D5BA
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2Gw0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 02:52:26 -0400
Received: from verein.lst.de ([213.95.11.211]:52424 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfE2Gw0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 02:52:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C437C68AFE; Wed, 29 May 2019 08:52:01 +0200 (CEST)
Date:   Wed, 29 May 2019 08:52:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/3] block: queue exit cleanup
Message-ID: <20190529065201.GA3728@lst.de>
References: <20190515030310.20393-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515030310.20393-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, do you plan to pick this up (at last patches 1 and 2)?  It
fixes a NULL pointer deref and a md raid issue.
