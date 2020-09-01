Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D4258970
	for <lists+linux-block@lfdr.de>; Tue,  1 Sep 2020 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgIAHlq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Sep 2020 03:41:46 -0400
Received: from verein.lst.de ([213.95.11.211]:52257 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHlq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 03:41:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB8ED68B05; Tue,  1 Sep 2020 09:41:43 +0200 (CEST)
Date:   Tue, 1 Sep 2020 09:41:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Some clean-ups for bio merge
Message-ID: <20200901074143.GA30547@lst.de>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
