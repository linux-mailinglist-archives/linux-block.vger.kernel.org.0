Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66D62EAEF8
	for <lists+linux-block@lfdr.de>; Tue,  5 Jan 2021 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbhAEPl5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Jan 2021 10:41:57 -0500
Received: from verein.lst.de ([213.95.11.211]:33588 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbhAEPl5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 10:41:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3144168B02; Tue,  5 Jan 2021 16:41:15 +0100 (CET)
Date:   Tue, 5 Jan 2021 16:41:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 3/6] block: don't allocate inline bvecs if this
 bioset needn't bvecs
Message-ID: <20210105154114.GB21138@lst.de>
References: <20210105124203.3726599-1-ming.lei@redhat.com> <20210105124203.3726599-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105124203.3726599-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
