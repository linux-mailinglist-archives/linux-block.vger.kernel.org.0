Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B86B189D3
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2019 14:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEIMdO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 May 2019 08:33:14 -0400
Received: from verein.lst.de ([213.95.11.211]:45572 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfEIMdO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 08:33:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6271A68AFE; Thu,  9 May 2019 14:32:55 +0200 (CEST)
Date:   Thu, 9 May 2019 14:32:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/dasd: fix build warning in dasd_eckd_build_cp_raw
Message-ID: <20190509123255.GA21483@lst.de>
References: <20190509100314.19152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509100314.19152-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
