Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8825A408EB6
	for <lists+linux-block@lfdr.de>; Mon, 13 Sep 2021 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbhIMNgX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Sep 2021 09:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241365AbhIMNdL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 09:33:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F4336139D;
        Mon, 13 Sep 2021 13:26:09 +0000 (UTC)
Date:   Mon, 13 Sep 2021 15:26:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] sysfs: split out binary attribute handling from
 sysfs_add_file_mode_ns
Message-ID: <20210913132607.yw2whevp4hj3rfke@wittgenstein>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:12AM +0200, Christoph Hellwig wrote:
> Split adding binary attributes into a separate handler instead of
> overloading sysfs_add_file_mode_ns.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
